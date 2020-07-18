# git & devops fasm - frequent shortcuts & mnemonics :-)

- **md** / make dir < dirName > && cd / .zshrc
- **mf** / make file < fileName > && code / .zshrc
- **cmdi** / install < cmdFile > in /usr/local/bin

## kubernetes

- **ka** / kubectl apply -f < yaml >
- **kp** / kubectl get pods
- **kd** / alias kd="kubectl get deployments" in ~/.zshrc
- **ks** / alias ks="kubectl get services" in ~/.zshrc
- **ke** / kubectl exec -it < podName > < cmd ~sh >
- **kl** / kubectl logs < podName >
- **kdp** / kubectl delete pod < podName >
- **kdd** / kubectl delete deployment < deplName >
- **kdesp** / kubectl describe pod < podName >
- **kdesd** / kubectl describe deployment < deplName >
- **kdess** / kubectl describe service < srvlName >
- **kr** / kubectl rollout restart deployment < deplName >

## docker

- **db** / docker build -t dockerUser/< image tag > .
- **dr** / docker run < image tag or id >
- **dri** / docker run -it < image tag > < cmd ~sh >
- **de** / docker exec -it < cont. id > < cmd ~sh >
- **dl** / docker logs < cont. id >
- **dp** / docker push dockerUser/< image > to dockerhub

## devops

- **fdr** / firebase deploy & resume coding (vue build > deploy > dev) / Franklin Delano Roosevelt

## git

- **gx** / gs > ga > gs > gc(cmd-v) > gp
- **ga** / git add .
- **gc** / git commit -am 'comment'
- **gl** / git log
- **gp** / git push
- **gs** / git status

## firebase

- **fd** / firebase deploy

## npm, vue

- **ns** / npm start
- **nrs** / npm run serve
- **nrb** / npm run build

## Mac install

- **cmdi** / command install in /usr/local/bin

```bash
cmdi < cmd >
```

copy files to /usr/local/bin

```bash
sudo cp * /usr/local/bin
```

might need to add permissions eg:

```bash
chmod +x /usr/local/bin/dr
# or
chmod 755 /usr/local/bin/dr
```
