# Running Kismet in a Docker Container

These steps will create a Kismet image from scratch.  The image creation process builds Kismet from source.  This is a CPU and RAM intensive process.  Depending on your computer this can take ***a long time*** (hours).

## Swap File Requirements for Low RAM Systems

If your system has only a small amount of RAM (i.e. low RAM VPS', Raspberry Pi, Beaglebone, Gateworks, LattePanda, or other SBCs) you need to create a temporary swap file to be used during the initial image build.  This is a **one-time*** requirement.  Once the image is built, you do not need a swap file to run a container.

## Steps

- [ ] In your preferred container storage path, create a `kismet` folder with a `config` and `logs` subfolder.  Once created, change to the `kismet` folder.

> Note: These steps assume your preferred path is `~/docker`.

```shell
mkdir -p ~/docker/kismet/{config,logs} && cd ~/docker/kismet
```

***

- [ ] Create a `Dockerfile`.  Add the contents of the `Dockerfile` in your lab files.  This Dockerfile create a smaller image file (< 1GB) by using a multi-stage image build.

- [ ] Create a `compose.yaml` file.  Add the contents of the `compose.yaml` file in your lab files.

- [ ] Create a `kismet_site.conf` file in the `config` folder.  Add the contents of the `kismet_site.conf` file in you lab files.

- [ ] Set permissions on `logs` so container can write to it (`chmod 776 logs`)

Your folder/file structure should look like this:

```shell
$ tree kismet
kismet
├── compose.yaml
├── config
│   └── kismet_site.conf
├── Dockerfile
└── logs
```

