select * 
from [cars additional info];

select *
from [cars lisence number];

select *
from [cars with Handicap badge];


--------
-- Cleaning some Data in [cars lisence number] Table
--------

-- Standardize Date Format

Select shnat_yitzur,
	mivchan_acharon_dt,
	tokef_dt,
	moed_aliya_lakvish
From [cars lisence number];


Update [cars lisence number]
SET shnat_yitzur = replace(shnat_yitzur, '"', ''), 
	mivchan_acharon_dt = CONVERT(Date, replace(mivchan_acharon_dt, '"', '')),
	tokef_dt = CONVERT(Date, replace(tokef_dt, '"', '')),
	moed_aliya_lakvish = replace(moed_aliya_lakvish, '"', '');

update [cars lisence number]
set mispar_rechev = REPLACE(mispar_rechev, '"', '');

update [cars lisence number]
set kvutzat_zihum = REPLACE(kvutzat_zihum, '"', '');

-- Look for Duplicates using a CTE
with DupsCTE AS (
select *,
	row_number() over
	(partition by mispar_rechev,
				  degem_nm,
				  misgeret,
				  kinuy_mishari
				  order by
				  mispar_rechev
				  ) row_num
from [cars lisence number])

select *
from DupsCTE
where row_num > 1

-- If deleting is needed we can run this lines 
--Delete 
--from DupsCTE
--where row_num > 1
;

select *
from [cars lisence number]
where mispar_rechev = 8443679;

--------
-- Cleaning some Data in [cars additional info] Table
--------

select *
from [cars additional info]
where kod_mehirut_tzmig_ahori <> kod_mehirut_tzmig_kidmi;

alter table [cars additional info]
add kod_mehirut_tzmigim Nvarchar(255)
update [cars additional info]
set kod_mehirut_tzmigim = replace(kod_mehirut_tzmig_ahori, '"', '');
alter table [cars additional info]
drop column kod_mehirut_tzmig_ahori, kod_mehirut_tzmig_kidmi;

select *
from [cars additional info]
where kod_omes_tzmig_ahori <> kod_omes_tzmig_kidmi;

alter table [cars additional info]
add kod_omes_tzmigim_kidmi_ahori Nvarchar(255);
update [cars additional info]
set kod_omes_tzmigim_kidmi_ahori = replace(kod_omes_tzmig_kidmi, '"', '') + ', ' + REPLACE(kod_omes_tzmig_ahori, '"', '');
alter table [cars additional info]
drop column kod_omes_tzmig_kidmi, kod_omes_tzmig_ahori;

alter table [cars additional info]
drop column grira_nm;

update [cars additional info]
set mispar_rechev = REPLACE(mispar_rechev, '"', '');

--------
-- Cleaning some Data in [cars with Handicap badge] Table
--------

select *
from [cars with Handicap badge];


alter table [cars with Handicap badge]
add TAARICH_HAFAKAT_TAG_CONVERTED Date;

update [cars with Handicap badge]
set TAARICH_HAFAKAT_TAG_CONVERTED = CONVERT(Date, 
									SUBSTRING([TAARICH HAFAKAT TAG], 7, 2)
									+ '/' + 
									SUBSTRING([TAARICH HAFAKAT TAG], 5, 2)
									+ '/' +
									SUBSTRING([TAARICH HAFAKAT TAG], 1, 4),
									 103);

alter table [cars with Handicap badge]
drop column [TAARICH HAFAKAT TAG];


----------
-- Exploring some Data
----------


-- Looking at number of vehicles per year of creation
select COUNT(mispar_rechev) as number_of_vehicles, shnat_yitzur
from [cars lisence number]
group by shnat_yitzur
order by 2;

-- Looking at numer of vehicles per level of pollution
select COUNT(mispar_rechev) as number_of_vehicles, 
		cast(kvutzat_zihum as int) as kvutzat_zihum
from [cars lisence number]
where kvutzat_zihum <> ''
group by kvutzat_zihum
order by 1 desc;


-- Looking at number of cars with Handicap badge per year
select COUNT(cl.mispar_rechev) as number_of_vehicles, cl.shnat_yitzur
from [cars lisence number] cl
join [cars with Handicap badge] ch
on cl.mispar_rechev = ch.[MISPAR RECHEV]
group by cl.shnat_yitzur
order by 1;


-- Cars that have a Handicap badge but their lisence number is not in the general table of cars
select *
from [cars with Handicap badge]
where [MISPAR RECHEV] not in (
				select cl.mispar_rechev
				from [cars lisence number] cl
				join [cars with Handicap badge] ch
				on cl.mispar_rechev = ch.[MISPAR RECHEV]
				);


-- Checking if the cars with Handicap badge are more polluting then their general percent

drop Table if exists #HandicapBadgeCarsWithPollutionGroupss
create Table #HandicapBadgeCarsWithPollutionGroups
(
number_of_vehicles nvarchar(255),
pollution_group nvarchar(255)
)
Insert into #HandicapBadgeCarsWithPollutionGroups
select COUNT(cl.mispar_rechev) as vehicles_number,
			cl.kvutzat_zihum
from [cars lisence number] cl
join [cars with Handicap badge] ch
on cl.mispar_rechev = ch.[MISPAR RECHEV]
where cl.kvutzat_zihum <> ''
group by kvutzat_zihum
order by vehicles_number desc;

----

drop Table if exists #CarsWithPollutionGroups
create Table #CarsWithPollutionGroups
(
number_of_vehicles nvarchar(255),
pollution_group nvarchar(255)
)
Insert into #CarsWithPollutionGroups
select cl.kvutzat_zihum,
		COUNT(cl.mispar_rechev) as vehicles_number
from [cars lisence number] cl
where cl.kvutzat_zihum <> ''
group by kvutzat_zihum
order by vehicles_number desc;

----

select cr.pollution_group, 
	cr.precentage_from_total as precentage_from_total_cars,
	ch.precentage_from_total as precentage_from_cars_Handicap
from
(select c.*, 
	cast((cast(c.number_of_vehicles as float)/cast(c.total_cars as float))*100 as int) as precentage_from_total 
from
(select cast(number_of_vehicles as int) as number_of_vehicles,
		pollution_group, 
		(SUM(cast(number_of_vehicles as int)) over ()) as total_cars
from #CarsWithPollutionGroups) c) cr
join
(select h.*,
	cast((cast(h.number_of_vehicles as float)/cast(h.total_cars_Handicap as float))*100 as int) as precentage_from_total 
from
(select cast(number_of_vehicles as int) as number_of_vehicles,
		pollution_group,
		(SUM(cast(number_of_vehicles as int)) over()) as total_cars_Handicap
from #HandicapBadgeCarsWithPollutionGroups) h) ch
on cr.pollution_group=ch.pollution_group 
order by pollution_group;