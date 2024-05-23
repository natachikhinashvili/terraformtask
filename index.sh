docker build -t nodeapp .

docker run -p 3000:3000 -d nodeapp

aws ecr get-login-password \
    --region eu-central-1 \
| docker login \
    --username AWS \
    --password-stdin 850286438394.dkr.ecr.eu-central-1.amazonaws.com

docker push 850286438394.dkr.ecr.eu-central-1.amazonaws.com/nodeapp
