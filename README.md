## Create .env file with
```
JUPYTER_TOKEN = "your token"
```

## Build and Run container with pyspark notebook
```
docker compose up --build
```

## Download data
Run notebook `01_dowload_and_extraction` with VSCode. Select "Existing Jupyter Server..." and paste the URL of server `http://<ip-address>:8888/?token=<your token>` and then select a new ipykernel

## Convert to parquet for better handling
Run notebook `02_convertion_to_parquet` with VSCode. Select the jupyter server as before.