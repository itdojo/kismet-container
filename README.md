# Running Kismet in a Docker Container

These steps will create a Kismet image from scratch.  The initial image creation process builds Kismet from source.  This is a CPU and RAM intensive process.  Depending on your computer this can take ***a long time*** (hours).  In my testing, a Raspberry Pi 4 will take several hours; a BeagleBone Black will take a 36-48 hours.

## Swap File Requirements for Low RAM Systems

If your system has only a small amount of RAM (i.e. low RAM VPS', Raspberry Pi, Beaglebone, Gateworks, LattePanda, or other SBCs) you need to create a temporary swap file to be used during the initial image build.  This is a **one-time*** requirement.  Once the image is built, you do not need a swap file to run a container.

If you need a swapfile you can use `make-swapfile.sh` to create a temporary swapfile.  You do not need a swapfile to run the container, just to build it.

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

Kismet's log file are written to `logs/`.

***

## Kismet with GPSD Stack

The folder **kismet-with-gpsd/** contains Docker files to build a container stack that runs both Kisment and GPSD.  You will need to edit the `.env` file with your GPS info.  You also need to update `kismet_site.conf` with the preferred Kismet settings you want to use.