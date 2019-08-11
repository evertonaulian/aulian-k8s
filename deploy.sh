docker build -t evertonaulian/multi-client:latest -t evertonaulian/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t evertonaulian/multi-server:latest -t evertonaulian/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t evertonaulian/multi-worker:latest -t evertonaulian/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push evertonaulian/multi-client:latest
docker push evertonaulian/multi-server:latest
docker push evertonaulian/multi-worker:latest

docker push evertonaulian/multi-client:$SHA
docker push evertonaulian/multi-server:$SHA
docker push evertonaulian/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=evertonaulian/multi-server:$SHA
kubectl set image deployments/client-deployment client=evertonaulian/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=evertonaulian/multi-worker:$SHA