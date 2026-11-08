docker container stop whisper-gpu2
docker container rm whisper-gpu2

docker build --progress=plain --file Dockerfile.gpu -t wyoming-whisper:gpu . \
&& docker run -d \
  --name whisper-gpu2 \
  --restart=unless-stopped \
  -v $PWD/hass_token:/extra_files/hass_token:ro \
  -v ~/whisper-data:/data \
  -e WYO_WHISPER_HASS_TOKEN_FILE=/extra_files/hass_token \
  -p 10302:10300 \
  --gpus all \
  wyoming-whisper:gpu --language de --model /data/final_model_ct2 --compute-type float32 --hass-api 