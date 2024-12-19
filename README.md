# Running Kismet in a Docker Container

These steps will create a Kismet image from scratch.  The image creation process builds Kismet from source.  This is a CPU and RAM intensive process.  Depending on your computer this can take ***a long time*** (hours).

## Swap File Requirements for Low RAM Systems

If your system has only a small amount of RAM (i.e. low RAM VPS', Raspberry Pi, Beaglebone, Gateworks, LattePanda, or other SBCs) you need to create a temporary swap file to be used during the initial image build.  This is a **one-time*** requirement.  Once the image is built, you do not need a swap file to run a container.

## Steps

- [ ] Clone this repo.  
- [ ] Edit `config/kismet_site.conf` to your liking.  Mostly this means specify the capture interface you prefer.
- [ ] Set permissions on `logs` so container can write to it (`chmod 776 logs`)
- [ ] Run `docker compose up -d`.

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

Kismet's log file are written to `logs/`