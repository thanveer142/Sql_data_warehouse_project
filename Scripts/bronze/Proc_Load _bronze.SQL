/*
======================================================================================================================
Stored Procedure : Load Data into bronze layer (source => Bronze)
======================================================================================================================
Script purpose :
    This stored procedure loads data into the 'bronze' schema from external csv files.
    It performs the following actions :
    - Truncates the bronze table before loading data 
    - uses the 'bulk insert' command to load data from csvfiles to bronze tables.

Usage :
Exce bronze.load.bronze
========================================================================================================================
*/




create or alter procedure bronze.load_bronze AS
Begin
	declare @start_time Datetime ,@end_time Datetime 
	Begin Try
		print '=============================================================================================='
		print 'Loading Bronze layer'
		print '=============================================================================================='
		print '----------------------------------------------------------------------------------------------'
		print 'Loading CRM Tables'
		print '______________________________________________________________________________________________'

		set @start_time = GETDATE();
		truncate table bronze.crm_cust_info;
		bulk insert bronze.crm_cust_info
			from 'E:\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with(
				firstrow =2,
				fieldterminator =',',
				tablock
			);
			

		Truncate table bronze.crm_prd_info;
		bulk insert  bronze.crm_prd_info
			from 'E:\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with (
				firstrow =2,
				fieldterminator =',',
				tablock
			);

			Truncate table bronze.crm_sales_details;
			bulk insert bronze.crm_sales_details
			from 'E:\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with(
				firstrow =2,
				fieldterminator = ',',
				tablock 
				);

			Truncate table bronze.erp_cust_az12;
			bulk insert  bronze.erp_cust_az12
			from 'E:\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			with(
				firstrow =2,
				fieldterminator = ',',
				tablock 
				);

			print'____________________________________________________________________________________________________'
			print'Loading erp table'
			print '___________________________________________________________________________________________________'
			Truncate table bronze.erp_px_cat_g1v2;

			bulk insert  bronze.erp_px_cat_g1v2
			from 'E:\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			with(
				firstrow =2,
				fieldterminator = ',',
				tablock 
				);

		Truncate table bronze.erp_loc_a101;
		bulk insert bronze.erp_loc_a101
		from 'E:\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\Loc_A101.csv'
		with (
			firstrow =2,
			fieldterminator =',',
			tablock
		);
		set @end_time = getdate();
		print'loading duration of bronze layer '+ cast(datediff(second,@start_time,@end_time) AS nvarchar)+ 'seconds'
	End Try
	Begin catch
	end catch

End
