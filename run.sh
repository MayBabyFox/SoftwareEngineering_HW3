#!/bin/bash

build_generator() {
    echo "Building generator image..."
    docker build -t generator ./generator
}

run_generator() {
    echo "Running generator container..."
    mkdir -p "$(pwd)/data"
    docker run --rm -v "$(pwd)/data:/data" generator
    echo "data.csv created in ./data/"
}

create_local_data() {
    echo "Generating data locally..."
    mkdir -p "$(pwd)/local_data"
    python generator/generate.py "$(pwd)/local_data"
    echo "data.csv created in ./local_data/"
}

build_reporter() {
    echo "Building reporter image..."
    docker build -t reporter ./reporter
}

run_reporter() {
    echo "Running reporter container..."
    if [ ! -f "$(pwd)/data/data.csv" ]; then
        echo "Error: data/data.csv not found. Please run './run.sh run_generator' first."
        exit 1
    fi
    docker run --rm -v "$(pwd)/data:/data" reporter
    echo "report.html created in ./data/"
}

case "$1" in
    build_generator)
        build_generator
        ;;
    run_generator)
        run_generator
        ;;
    create_local_data)
        create_local_data
        ;;
    build_reporter)
        build_reporter
        ;;
    run_reporter)
        run_reporter
        ;;
    *)
        echo "Usage: $0 {build_generator|run_generator|create_local_data|build_reporter|run_reporter}"
        exit 1
        ;;
esac