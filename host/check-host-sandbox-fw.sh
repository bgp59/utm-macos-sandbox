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

echo "Tables for '$anchor':"
tables=$(sudo pfctl -a $anchor -s Table 2>/dev/null)
has_allowed_dns=
has_blocked_ranges=
for t in $tables; do
    echo " $t"
    ignore_table=
    case "$t" in
        allowed_dns) has_allowed_dns=1;;
        blocked_ranges) has_blocked_ranges=1;;
        *) ignore_table=1;;
    esac
    if [[ -z "$ignore_table" ]]; then
        sudo pfctl -a $anchor -t $t -T show 2>/dev/null
    fi
done
if [[ "$has_allowed_dns" = 1 && "$has_blocked_ranges" = 1 ]]; then
    echo "Tables: OK"
else
    echo "Tables: not OK"
fi
echo

echo "Rules for '$anchor':"
sudo pfctl -a $anchor -s r 2>/dev/null | (
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