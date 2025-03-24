# ![veld chain](https://raw.githubusercontent.com/veldhub/.github/refs/heads/main/images/symbol_V_letter.png) veld_chain__REPLACE

This repo contains [chain velds](https://zenodo.org/records/13322913) encapsulating REPLACE

## requirements

- git
- docker compose (note: older docker compose versions require running `docker-compose` instead of 
  `docker compose`)

Clone this repo with all its submodules
```
git clone --recurse-submodules REPLACE
```

## how to reproduce

The following chain velds were used. Open the respective veld yaml file for more information.

**[./veldREPLACE.yaml](./veldREPLACE.yaml)** 

REPLACE

```
docker compose -f veldREPLACE.yaml up
```

