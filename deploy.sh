docker build -t andresalvarezewe/multi-client:latest -t andresalvarezewe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andresalvarezewe/multi-server:latest -t andresalvarezewe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andresalvarezewe/multi-worker:latest -t andresalvarezewe/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andresalvarezewe/multi-client:latest
docker push andresalvarezewe/multi-server:latest
docker push andresalvarezewe/multi-worker:latest

docker push andresalvarezewe/multi-client:$SHA
docker push andresalvarezewe/multi-server:$SHA
docker push andresalvarezewe/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=andresalvarezewe/multi-client:$SHA
kubectl set image deployments/server-deployment server=andresalvarezewe/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=andresalvarezewe/multi-worker:$SHA
