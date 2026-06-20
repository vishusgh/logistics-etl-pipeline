-- Author: Vishal Singh
-- target: Sql Queries on cleaned logitic data 
-- Database: Google Bigquery

-- --------------------------------------------------------------------
-- task 1: top 5 destination cities by freight amount
-- --------------------------------------------------------------------
select 
  destination_city, 
  round(sum(freight_amount_usd), 2) as total_freight_usd
from `assessment-nextaccel.logistics_data.Master_Logistics`
where destination_city is not null
group by 1
order by total_freight_usd desc
limit 5;


-- --------------------------------------------------------------------
-- task 2: city with highest cod (cash on delivery) orders
-- --------------------------------------------------------------------
select 
  origin_city, 
  count(booking_id) as total_cod_orders
from `assessment-nextaccel.logistics_data.Master_Logistics`
where payment_mode = 'COD'
  and booking_date is not null
group by 1
order by total_cod_orders desc
limit 1;


-- --------------------------------------------------------------------
-- task 3: average delivery time by vehicle type
-- --------------------------------------------------------------------
select 
  coalesce(vehicle_type, 'Unknown') as vehicle_type, 
  round(avg(date_diff(date(delivery_date), date(booking_date), day)), 2) as avg_delivery_days
from `assessment-nextaccel.logistics_data.Master_Logistics`
where shipment_status = 'Delivered'
  and delivery_date is not null 
  and booking_date is not null
group by 1
order by avg_delivery_days asc;


-- --------------------------------------------------------------------
-- task 4: top 10 employees with high productivity
-- --------------------------------------------------------------------
select 
  employee_id,
  employee_name, 
  count(booking_id) as total_bookings_processed
from `assessment-nextaccel.logistics_data.Master_Logistics`
where employee_id is not null 
  and booking_date is not null
group by 1, 2
order by total_bookings_processed desc
limit 10;


-- --------------------------------------------------------------------
-- task 5: top performing customer
-- --------------------------------------------------------------------
select 
  customer_id,
  customer_name, 
  round(sum(freight_amount_usd), 2) as total_freight_spent_usd
from `assessment-nextaccel.logistics_data.Master_Logistics`
where customer_id is not null
group by 1, 2
order by total_freight_spent_usd desc
limit 1;