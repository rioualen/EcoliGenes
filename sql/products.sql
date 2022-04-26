select
  P.product_id as RegulonDB_product_id,
  P.product_name as RegulonDB_product_name,
  group_concat(distinct GBNUM.bnumber) as RegulonDB_bnumber,
	  group_concat(distinct G.gene_id) as RegulonDB_gene_id,
	  group_concat(distinct G.gene_name) as RegulonDB_symbol,
	  group_concat(distinct P.product_type) as RegulonDB_product_type,
	  group_concat(distinct TF.transcription_factor_id) as RegulonDB_tf_id,
	  group_concat(distinct TF.transcription_factor_name) as RegulonDB_tf_name,
	  group_concat(distinct OBSYN2.object_synonym_name) as product_synonyms
		from
			(select product_id,product_name,product_type from PRODUCT) as P
        left join (select * from GENE_PRODUCT_LINK) as GPLN
			on P.product_id = GPLN.product_id
        left join (select gene_id,gene_name from GENE) as G
			on GPLN.gene_id = G.gene_id
 		left join (select ecocyc_id,bnumber,gene_id from GENE_BNUMBER_TMP) as GBNUM
			on G.gene_id = GBNUM.gene_id
		left join OBJECT_SYNONYM as OBSYN2
			on P.product_id = OBSYN2.object_id
        left join PRODUCT_TF_LINK as TFPLN
			on TFPLN.product_id = P.product_id
        left join TRANSCRIPTION_FACTOR as TF
			on TFPLN.transcription_factor_id = TF.transcription_factor_id
	    group by P.product_id,P.product_name;
