#! /bin/bash

# this file should be in patch/EvmRewriter/

usage() {
    echo "Usage:"
    echo "  run_evmRewriter.sh [-h] [-t TIME] [-d DATASET] [-m METADATA] [-o OUTPUT] [-r REPORT]"
    echo "Description:"
    echo "  -h                  :show help infomation"
    echo "  -t (TIME)           :time limit in seconds (per bytecode)"
    echo "  -d (DATASET)    :on which dataset is running"
    echo "  -m (METADATA)       :metadata directory"
    echo "  -o (OUTPUT)         :write patched bytecode to OUTPUT directory"
    echo "  -r (REPORT)         :write patching report to REPORT directory"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

while getopts 'ht:d:m:o:r:' OPT; do
    case $OPT in
        h) usage
            exit;;
        t) time_limit=$OPTARG;;
        d) dataset=$OPTARG;;
        m) meta_dir=$OPTARG;;
        o) out_dir=$OPTARG;;
        r) report_dir=$OPTARG;;
        ?) usage
            exit;;
    esac
done    

shift $((OPTIND -1))
if [ $# -gt 0 ]; then
    echo "Wrong usage"
    usage
    exit 1;
fi

if [[ ! ${time_limit} || ! ${dataset} || ! ${meta_dir} || ! ${out_dir} || ! ${report_dir} ]]; then
    echo "Missing argument!"
    usage
    exit 1
fi

source ../evmrewriter_venv/bin/activate

total=`ls ${meta_dir}| wc -l`
count=0
start=`date +%s`
for metadata in `ls ${meta_dir}`;do
    addr=${metadata%.json}
    echo "Patching ${addr}..."
    python3 evm_rewriter.py -b ${dataset}/${addr}.bin -m ${meta_dir}/${metadata} -t ${time_limit} -o ${out_dir}/${addr}_patched.bin -r ${report_dir}/${addr}.json
    end=`date +%s`
    count=$[count + 1]
    cost=$[end - start]

    echo -e "\033[36m"
    echo "${count} patched, ${total} total."
    echo "cost ${cost} seconds total"
    echo -e "\033[0m"
done

deactivate