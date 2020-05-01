docker build -t shawr3/multi-client:latest -t shawr3/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shawr3/multi-server:latest -t shawr3/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shawr3/multi-worker:latest -t shawr3/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shawr3/multi-client:latest
docker push shawr3/multi-server:latest
docker push shawr3/multi-worker:latest

docker push shawr3/multi-client:$SHA
docker push shawr3/multi-server:$SHA
docker push shawr3/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shawr3/multi-server:$SHA
kubectl set image deployments/client-deployment client=shawr3/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shawr3/multi-worker:$SHA
