select 
  G.gene_id as RegulonDB_gene_id,
  G.gene_name as RegulonDB_symbol,
  group_concat(distinct GBNUM.bnumber) as RegulonDB_bnumber,
	  min(G.gene_posleft) as RegulonDB_start,
	  min(G.gene_posright) as RegulonDB_stop,
	  group_concat(distinct G.gene_strand) as RegulonDB_strand,
	  group_concat(distinct G.gene_type) as RegulonDB_type,
	  group_concat(distinct P.product_id) as RegulonDB_product_id,
	  group_concat(distinct P.product_name) as RegulonDB_product_name,
	  group_concat(distinct P.product_type) as RegulonDB_product_type,
  	  group_concat(distinct GBNUM.ecocyc_id) as Ecocyc_id,
	  group_concat(distinct OBSYN.object_synonym_name) as gene_synonyms,
	  group_concat(distinct OBSYN2.object_synonym_name) as product_synonyms
		from 
			(select gene_id,gene_name,gene_posleft,gene_posright,gene_strand,gene_type from regulondb.GENE) as G
		left join (select ecocyc_id,bnumber,gene_id from regulondb.GENE_BNUMBER_TMP) as GBNUM
        on G.gene_id = GBNUM.gene_id
        left join (select * from regulondb.GENE_PRODUCT_LINK) as GPLN
        on G.gene_id = GPLN.gene_id
        left join (select product_id,product_name,product_type from regulondb.PRODUCT) as P
        on GPLN.product_id = P.product_id
        left join regulondb.OBJECT_SYNONYM as OBSYN
        on G.gene_id = OBSYN.object_id  
         left join regulondb.OBJECT_SYNONYM as OBSYN2
        on P.product_id = OBSYN2.object_id
	    group by G.gene_id,G.gene_name;