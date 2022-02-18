-- 1 
-- 42084899
select count(*)
from `dtc-de-338713.nytaxi.external_fhv_tripdata`;


-- 2
-- 792
select count(distinct dispatching_base_num)
from `dtc-de-338713.nytaxi.external_fhv_tripdata`;


-- 3
-- Partition by dropoff_datetime and cluster by dispatching_base_num


-- 4
-- Count: 26558, Estimated data processed: 400.1 MB, Actual data processed: 149.2 MB
select count(*)
from `dtc-de-338713.nytaxi.fhv_tripdata_part_clus`
where dropoff_datetime between '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987', 'B02060', 'B02279');


-- 5
-- both columns are not balanced with the majority of the rows only in few values
select dispatching_base_num, count(*)
from `dtc-de-338713.nytaxi.fhv_tripdata_part_clus`
group by 1
order by 2 desc;

select SR_Flag, count(*)
from `dtc-de-338713.nytaxi.fhv_tripdata_part_clus`
group by 1
order by 2 desc;


-- 6
-- Can be worse due to metadata


-- 7
-- Columnar
