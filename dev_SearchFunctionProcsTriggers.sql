SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Modified:	04/22/219
-- Description:	Search stored procedure, function, table type and triggers for a given string 
-- EXEC dev_SearchFnAndProcs ''
-- =============================================
ALTER PROCEDURE [dbo].[dev_SearchFunctionProcsTriggers]
(
	@Search VARCHAR(MAX)
)
AS

BEGIN

	SELECT
	 O.object_id,
	 O.name,
	 O.type_desc,
	 O.create_date,
	 O.modify_date,
	 M.definition
	 FROM 
	SYS.objects AS o 
		INNER JOIN sys.sql_MODULES as M 
			ON o.object_id = m.object_id
		WHERE TYPE in ('P', 'FN', 'TF', 'IF', 'TT', 'TR')
		AND m.definition like '%'+@Search+'%'
		Order by o.object_id desc 

END


