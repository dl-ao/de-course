-- 1
-- 61602997
SELECT count(*) 
FROM `dtc-de-338713.dbt_dl.fact_trips`
where date(pickup_datetime) between '2019-01-01' and '2020-12-31';


-- 2
-- from google data studio - 89.9/10.1
SELECT count(*) as tot, 
    sum(case when service_type = 'Green' then 1 else 0 end) as green,
    sum(case when service_type = 'Yellow' then 1 else 0 end) as yellow,
    sum(case when service_type = 'Green' then 1 else 0 end)/count(*)*100 as green_perc,
    sum(case when service_type = 'Yellow' then 1 else 0 end)/count(*)*100 as yellow_perc
FROM `dtc-de-338713.dbt_dl.fact_trips`
where date(pickup_datetime) between '2019-01-01' and '2020-12-31';


-- 3
-- 42084899
SELECT count(*) 
FROM `dtc-de-338713.dbt_dl.stg_fhv_tripdata`
where date(pickup_datetime) between '2019-01-01' and '2019-12-31';


-- 4
-- 22676253
SELECT count(*) 
FROM `dtc-de-338713.dbt_dl.fact_trips_fhv`
where date(pickup_datetime) between '2019-01-01' and '2019-12-31';


-- 5
-- from google data studio - January
SELECT extract(month from pickup_datetime) as month, count(*) as cnt
FROM `dtc-de-338713.dbt_dl.fact_trips_fhv`
where date(pickup_datetime) between '2019-01-01' and '2019-12-31'
group by 1
order by cnt;