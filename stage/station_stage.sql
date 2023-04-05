IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacityabdabd_udacityabdabd_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacityabdabd_udacityabdabd_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacityabdabd@udacityabdabd.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE dbo.station_stage (
	station_id nvarchar(100),
	name nvarchar(100),
	latitude float,
	longitude float
	)
	WITH (
	LOCATION = 'station.csv',
	DATA_SOURCE = [udacityabdabd_udacityabdabd_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.station_stage
GO