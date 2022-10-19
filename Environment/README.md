## Testing the terminal locally

You should have a local Kubernets cluster running on your machine to test all the functionality out.

> Please make sure your `kubectl` is configured to use the local cluster and not a real one.
> You can check this with `kubectl config current-context`.

### 1. Building the local version of `studio-terminal`
From the root of the repository, run:
```shell
$ docker build -t studio-terminal:local .
...
 => exporting to image
 => => exporting layers
 => => writing image sha256:efa5836adb616bd172ed220c8124fa9270061b60507b77439e3a1e90b72db0a1
 => => naming to docker.io/library/studio-terminal:local 
```

### 2. Setup the Kubernets resources
From the root of the repository, run:
```shell
$ kubectl apply -f Environment/setup.yml
...
deployment.apps/prod-selfservice created
service/prod-mongo created
statefulset.apps/prod-mongo created
```

### 3. Port forward to the shell 
From the root of the repository, run:
```shell
$ Environment/port-forward.sh
...
Forwarding from [::1]:7681 -> 7681
```

You can now visit [http://localhost:7681](http://localhost:7681) to interact with the running `studio-terminal`.

### 4. Rebuild and restart
When you've made any changes, run all of these commands to restart:
```shell
$ docker build -t studio-terminal:local .
...
$ Environment/restart.sh
...
$ Environment/port-forward.sh
...
```