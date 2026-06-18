#!/bin/bash

echo "Failed SSH Attempts:"
grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l
