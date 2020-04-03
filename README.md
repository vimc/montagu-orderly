# montagu-orderly

[![Build status](https://badge.buildkite.com/e06115d248134fa4ce0dd07a77be3e06420cafc963142404ae.svg?branch=master)](https://buildkite.com/mrc-ide/montagu-orderly)

This is the docker container for [montagu-reports](https://github.com/vimc/montagu-reports).  It exists outside that repository because otherwise every new report we use risks dragging in a new LaTeX installation

Interaction with montagu.  These commands interact with the montagu version on the *same host* as you run it.  If you run these on your desktop they will not affect any other machine.

Make sure you have the most recent version of the container with with

```
docker pull docker.montagu.dide.ic.ac.uk:5000/montagu-orderly:master
```

Update the montagu-report repo on the orderly volume

```
./orderly_montagu_sh.sh git pull
```

Run orderly commands with

```
./orderly_montagu.sh run <name>
./orderly_montagu.sh list names
./orderly_montagu.sh --help
```

etc.
