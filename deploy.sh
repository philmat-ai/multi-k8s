docker build -t philmatai/multi-client:latest -t philmatai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t philmatai/multi-server:latest -t philmatai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t philmatai/multi-worker:latest -t philmatai/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push philmatai/multi-client:latest
docker push philmatai/multi-server:latest
docker push philmatai/multi-worker:latest
docker push philmatai/multi-client:$SHA
docker push philmatai/multi-server:$SHA
docker push philmatai/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=philmatai/multi-server:$SHA
kubectl set image deployments/client-deployment client=philmatai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=philmatai/multi-worker:$SHA