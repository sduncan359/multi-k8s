docker build -t sduncan359/multi-client:latest -t sduncan359/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sduncan359/multi-server:latest -t sduncan359/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sduncan359/multi-worker:latest -t sduncan359/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sduncan359/multi-client:latest
docker push sduncan359/multi-server:latest
docker push sduncan359/multi-worker:latest

docker push sduncan359/multi-client:$SHA
docker push sduncan359/multi-server:$SHA
docker push sduncan359/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sduncan359/multi-server:$SHA
kubectl set image deployments/client-deployment client=sduncan359/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sduncan359/multi-worker:$SHA