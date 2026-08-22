#! /bin/bash

# Check that the UTM sandbox isolation rules are installed:

anchor=com.utm.sandbox

x=0
sudo pfctl -s info 2>/dev/null | (
    x=1
    while read line; do
    if [[ "$line" = "Status:"* ]]; then
        echo "$line"
        [[ "$line" = *"Enabled"* ]] && x=0
    fi
    done
    exit $x
)
if [[ "$?" = 0 ]]; then
    echo "Status: OK"
else    
    echo "Status: not OK"
    x=1
fi
echo

echo "Anchors:"
sudo pfctl -s Anchor 2>/dev/null | (
    x=1
    while read line; do
        echo " $line"
        [[ "$line" = "$anchor" ]] && x=0
    done
    exit $x
)
if [[ "$?" = 0 ]]; then
    echo "Anchors: OK"
else    
    echo "Anchors: not OK, '$anchor' not found"
    x=1
fi
echo

echo "Rules for '$anchor':"
sudo pfctl -a com.utm.sandbox -s r 2>/dev/null | (
    x=1
    while read line; do
        echo "$line"
        [[ "$line" = block* ]] && x=0
    done
    exit $x
)
if [[ "$?" = 0 ]]; then
    echo "Rules: OK"
else    
    echo "Rules: not OK, no block found"
    x=1
fi

echo
if [[ "$x" = 0 ]]; then
    echo "Overall: OK"
else
    echo "Overall: not OK"
fi