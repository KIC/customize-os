#!/bin/bash
xinput | grep touch

echo "run xinput disable [id]"

xinput | grep touch | grep -oP "id=(\d+)" | sed "s/id=//" | head -1 | xargs xinput disable
