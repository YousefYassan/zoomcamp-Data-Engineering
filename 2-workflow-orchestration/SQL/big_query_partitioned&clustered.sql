




CREATE TABLE public.green_tripdata_partitioned_clustered (
    
            unique_row_id          text,
            filename               text,
            VendorID               text,
            lpep_pickup_datetime   timestamp,
            lpep_dropoff_datetime  timestamp,
            store_and_fwd_flag     text,
            RatecodeID             text,
            PULocationID           text,
            DOLocationID           text,
            passenger_count        integer,
            trip_distance          double precision,
            fare_amount            double precision,
            extra                  double precision,
            mta_tax                double precision,
            tip_amount             double precision,
            tolls_amount           double precision,
            ehail_fee              double precision,
            improvement_surcharge  double precision,
            total_amount           double precision,
            payment_type           integer,
            trip_type              integer,
            congestion_surcharge   double precision
        ) PARTITION BY RANGE (DATE(lpep_pickup_datetime));


/*
SELECT 
    MIN(DATE(tpep_pickup_datetime)) as min_date,
    MAX(DATE(tpep_pickup_datetime)) as max_date
FROM public.yellow_tripdata;
*/


CREATE TABLE public.green_tripdata_y2021m001 PARTITION OF public.green_tripdata_partitioned_clustered
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');
    
CREATE TABLE public.green_tripdata_y2021m002 PARTITION OF public.green_tripdata_partitioned_clustered
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');
    
CREATE TABLE public.green_tripdata_y2021m003 PARTITION OF public.green_tripdata_partitioned_clustered
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

   
CREATE TABLE public.green_tripdata_y2021m004 PARTITION OF public.green_tripdata_partitioned_clustered
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

   
CREATE TABLE public.green_tripdata_y2021m005 PARTITION OF public.green_tripdata_partitioned_clustered
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');
	
   
CREATE TABLE public.green_tripdata_y2021m006 PARTITION OF public.green_tripdata_partitioned_clustered
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');


CREATE TABLE public.green_tripdata_default_clustered PARTITION OF public.green_tripdata_partitioned_clustered DEFAULT;


CREATE INDEX ON public.green_tripdata_partitioned_clustered (lpep_pickup_datetime);
CREATE INDEX ON public.green_tripdata_partitioned_clustered (lpep_dropoff_datetime);

INSERT INTO public.green_tripdata_partitioned_clustered
SELECT * FROM public.green_tripdata;


-- SELECT 
--     tableoid::regclass AS partition_name,
--     COUNT(*) AS row_count
-- FROM public.yellow_tripdata_partitioned
-- GROUP BY tableoid
-- ORDER BY partition_name;
-- */

-- /*
-- CREATE OR REPLACE FUNCTION create_monthly_partitions(
--     start_date DATE,
--     end_date DATE
-- ) RETURNS void AS $$
-- DECLARE
--     partition_date DATE := start_date;
--     next_date DATE;
--     partition_name TEXT;
-- BEGIN
--     WHILE partition_date < end_date LOOP
--         next_date := DATE_TRUNC('MONTH', partition_date) + INTERVAL '1 MONTH';
--         partition_name := 'public.yellow_tripdata_y' || 
--                           TO_CHAR(partition_date, 'YYYY') || 
--                           'm' || 
--                           TO_CHAR(partition_date, 'MM');
        
--         EXECUTE format(
--             'CREATE TABLE IF NOT EXISTS %I PARTITION OF public.yellow_tripdata_partitioned
--              FOR VALUES FROM (%L) TO (%L)',
--             partition_name,
--             partition_date,
--             next_date
--         );
        
--         partition_date := next_date;
--     END LOOP;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- SELECT create_monthly_partitions('2021-01-01', '2022-01-01');
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- if prev query   not give you values you wnat try this 

CREATE TABLE public.green_tripdata_partitioned (
   
            unique_row_id          text,
            filename               text,
            VendorID               text,
            lpep_pickup_datetime   timestamp,
            lpep_dropoff_datetime  timestamp,
            store_and_fwd_flag     text,
            RatecodeID             text,
            PULocationID           text,
            DOLocationID           text,
            passenger_count        integer,
            trip_distance          double precision,
            fare_amount            double precision,
            extra                  double precision,
            mta_tax                double precision,
            tip_amount             double precision,
            tolls_amount           double precision,
            ehail_fee              double precision,
            improvement_surcharge  double precision,
            total_amount           double precision,
            payment_type           integer,
            trip_type              integer,
            congestion_surcharge   double precision
        ) PARTITION BY RANGE (DATE(lpep_pickup_datetime));


/*
SELECT 
    MIN(DATE(tpep_pickup_datetime)) as min_date,
    MAX(DATE(tpep_pickup_datetime)) as max_date
FROM public.yellow_tripdata;
*/


CREATE TABLE public.green_tripdata_y2021m01 PARTITION OF public.green_tripdata_partitioned
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');
    
CREATE TABLE public.green_tripdata_y2021m02 PARTITION OF public.green_tripdata_partitioned
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');
    
CREATE TABLE public.green_tripdata_y2021m03 PARTITION OF public.green_tripdata_partitioned
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

   
CREATE TABLE public.green_tripdata_y2021m04 PARTITION OF public.green_tripdata_partitioned
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

   
CREATE TABLE public.green_tripdata_y2021m05 PARTITION OF public.green_tripdata_partitioned
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');
	
   
CREATE TABLE public.green_tripdata_y2021m06 PARTITION OF public.green_tripdata_partitioned
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');


CREATE TABLE public.green_tripdata_default PARTITION OF public.green_tripdata_partitioned DEFAULT;


CREATE INDEX ON public.green_tripdata_partitioned (lpep_pickup_datetime);
CREATE INDEX ON public.green_tripdata_partitioned (lpep_dropoff_datetime);


INSERT INTO public.green_tripdata_partitioned
SELECT * FROM public.green_tripdata;

/*
SELECT 
    tableoid::regclass AS partition_name,
    COUNT(*) AS row_count
FROM public.yellow_tripdata_partitioned
GROUP BY tableoid
ORDER BY partition_name;
*/

/*
CREATE OR REPLACE FUNCTION create_monthly_partitions(
    start_date DATE,
    end_date DATE
) RETURNS void AS $$
DECLARE
    partition_date DATE := start_date;
    next_date DATE;
    partition_name TEXT;
BEGIN
    WHILE partition_date < end_date LOOP
        next_date := DATE_TRUNC('MONTH', partition_date) + INTERVAL '1 MONTH';
        partition_name := 'public.yellow_tripdata_y' || 
                          TO_CHAR(partition_date, 'YYYY') || 
                          'm' || 
                          TO_CHAR(partition_date, 'MM');
        
        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS %I PARTITION OF public.yellow_tripdata_partitioned
             FOR VALUES FROM (%L) TO (%L)',
            partition_name,
            partition_date,
            next_date
        );
        
        partition_date := next_date;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SELECT create_monthly_partitions('2021-01-01', '2022-01-01');





--after you run prev query run this



BEGIN;
CREATE INDEX vendorid_idx ON public.green_tripdata_partitioned_clustered (VendorID);
COMMIT; -- قم بإنهاء المعاملة قبل CLUSTER

CLUSTER public.green_tripdata_partitioned_clustered USING vendorid_idx; 


