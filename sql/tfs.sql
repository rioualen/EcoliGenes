select 
	TF.transcription_factor_name as RegulonDB_tf_name,
	TF.transcription_factor_id as RegulonDB_tf_id,  
	group_concat(distinct TF.symmetry) as RegulonDB_tf_symmetry,
	group_concat(distinct TF.transcription_factor_family) as RegulonDB_tf_family,
	group_concat(distinct TF.connectivity_class) as RegulonDB_tf_class,
	#group_concat(distinct TF.sensing_class) as RegulonDB_tf_sensing,
	#group_concat(distinct TF.consensus_sequence) as RegulonDB_tf_consensus,
	group_concat(distinct C.conformation_id) as RegulonDB_tf_conformation_id,
	group_concat(distinct C.final_state) as RegulonDB_tf_conformation_final_state,
	group_concat(distinct C.conformation_type) as RegulonDB_tf_conformation_type,
	group_concat(distinct C.interaction_type) as RegulonDB_tf_interaction_type,
	group_concat(distinct C.apo_holo_conformation) as RegulonDB_tf_apo_holo,
    EXT_IDS.UNIPROT as Uniprot_ID,
    EXT_IDS.PFAM as Pfam_ID,
    EXT_IDS.REFSEQ as Refseq_ID
	#group_concat(distinct EXT_IDS.ext_reference_id) as External_tf_ids
from TRANSCRIPTION_FACTOR TF
left join CONFORMATION C
	on TF.transcription_factor_id = C.transcription_factor_id
left join (
	#select LN.object_id,LN.ext_reference_id from OBJECT_EXTERNAL_DB_LINK LN
	#left join EXTERNAL_DB DB on LN.external_db_id = DB.external_db_id
	#where DB.external_db_name in('UNIPROT','REFSEQ', 'PFAM')
    select 
		LN.object_id,
		group_concat(distinct case when DB.external_db_name = 'UNIPROT' then LN.ext_reference_id else null end) as UNIPROT,
		group_concat(distinct case when DB.external_db_name = 'PFAM' then LN.ext_reference_id else null end) as PFAM,
		group_concat(distinct case when DB.external_db_name = 'REFSEQ' then LN.ext_reference_id else null end) as REFSEQ
	from OBJECT_EXTERNAL_DB_LINK LN
	left join EXTERNAL_DB DB 
		on LN.external_db_id = DB.external_db_id
		where DB.external_db_name in('UNIPROT','REFSEQ', 'PFAM')
	group by LN.object_id    
) as EXT_IDS
	on TF.transcription_factor_id = EXT_IDS.object_id
group by TF.transcription_factor_id,TF.transcription_factor_name
order by TF.transcription_factor_name;




