#!/usr/bin/env python
# coding: utf-8

# ### Setting up file paths

# In[ ]:


workdir = './work/'
parquetdir = './parquet/'
source_csv = 'votacao_candidato_munzona_2022_BRASIL.csv'
extracted_file = workdir +'extracted/'+source_csv


# ### Creating Spark session

# In[ ]:


from pyspark.sql import SparkSession

# Create a SparkSession
spark_session = SparkSession.builder.appName('spark').getOrCreate()


# ### Reading file

# In[ ]:


df = spark_session.read.options(header="true", delimiter=";", encoding="ISO-8859-1").csv(extracted_file)


# ### Selecting relevant columns

# In[ ]:


# Defining relevant columns
relevant_columns=[
    "NR_TURNO",
    "DS_ELEICAO",
    "TP_ABRANGENCIA",
    "SG_UF",
    "NM_MUNICIPIO",
    "NR_ZONA",
    "DS_CARGO",
    "NR_CANDIDATO",
    "NM_CANDIDATO",
    "NM_URNA_CANDIDATO",
    "DS_SITUACAO_CANDIDATURA",
    "NR_PARTIDO",
    "SG_PARTIDO",
    "NM_PARTIDO",
    "NM_COLIGACAO",
    "DS_COMPOSICAO_COLIGACAO",
    "ST_VOTO_EM_TRANSITO",
    "QT_VOTOS_NOMINAIS",
    "NM_TIPO_DESTINACAO_VOTOS",
    "QT_VOTOS_NOMINAIS_VALIDOS",
    "DS_SIT_TOT_TURNO"
]

# Selecting relevant columns
selected_columns_df = df.select(relevant_columns)


# ### Printing first lines

# In[ ]:


selected_columns_df.show()


# ### Writing to parquet file

# In[ ]:


selected_columns_df.write.mode("overwrite").options(encoding="UTF-8").parquet(parquetdir + source_csv + ".parquet")


# ### Cleaning up

# In[ ]:


# Stopping spark session
spark_session.stop()

# Cleaning up files 
# Delete the directory and all its contents
# import shutil

# shutil.rmtree(workdir+'extracted/')

