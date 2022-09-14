t=("a" "b" "c" "d" "e" "f")
for i in "${t[@]}"; do
    export A_${i}=tada
    echo ${A_${i}}
done