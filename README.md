# Create and run Azkaban on podman

## Compile Azkaban on your workstation and create a tarball for the installation in the podman image

```shell
sudo dnf install java-1.8.0-openjdk-openjfx
curl -O https://github.com/azkaban/azkaban/archive/refs/tags/3.57.0.tar.gz
tar -zxvf 3.57.0.tar.gz
cd azkaban; ./gradlew build installDist
tar -zcvf azkaban-solo-server.tar.gz azkaban/azkaban-solo-server/build/install/azkaban-solo-server
```

## Build the podman image

```shell
podman build --tag centos:azkaban -f ./Containerfile
```

## Run the Azkaban Solo Server in the podman image

```shell
# run Azkaban in the podman image
podman run -dit -p 8081:8081 --rm centos:azkaban

# attach to the running container (e.g. to interact with Azkaban server or stop the container)
podman attach -l
```
