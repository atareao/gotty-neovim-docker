#!/bin/sh

/app/gotty --port ${PORT:-3000} --permit-write --reconnect bash
