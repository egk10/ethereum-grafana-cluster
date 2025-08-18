# Ethereum Validator Cluster Monitoring with Grafana and Prometheus

This repository contains the configuration for a comprehensive monitoring solution for an Ethereum validator cluster. It uses Prometheus for metrics collection and Grafana for visualization, providing detailed dashboards to track validator performance, hardware status, and protocol-specific metrics.

## Features

- **Multi-Node Monitoring:** Track the health and performance of multiple validator nodes from a single dashboard.
- **Templated Dashboards:** Easily switch between different nodes and validator types using templated dashboards.
- **Performance Insights:** Monitor key performance indicators such as attestation success rate, proposal success rate, and inclusion distance.
- **Hardware Monitoring:** Keep an eye on CPU usage, memory, disk space, and temperature for each node.
- **Protocol-Specific Dashboards:** Dedicated dashboards for various staking protocols like Rocketpool, Lido, EtherFi, and NodeSet.
- **Dockerized Setup:** The entire monitoring stack is containerized using Docker Compose for easy deployment and management.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your monitoring machine.
- Access to the metrics endpoints of your validator nodes.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/egk10/ethereum-grafana-cluster.git
    cd ethereum-grafana-cluster
    ```

2.  **Configure Prometheus:**
    -   Edit `prometheus/prometheus.yml` to match the IP addresses and ports of your validator nodes.
    -   The `relabel_configs` are used to add identifying labels to your nodes, so be sure to update those as well.

3.  **Configure Validator Metrics:**
    -   Edit `ethereum-metrics/config.yaml` to include the public keys of your validators. This is necessary for the `ethereum-metrics-exporter` to pull performance data from the beacon chain.

4.  **Start the monitoring stack:**
    ```bash
    docker-compose up -d
    ```

5.  **Access Grafana:**
    -   Open your web browser and navigate to `http://<your-monitoring-machine-ip>:3000`.
    -   Log in with the default credentials (admin/validator123). You should change the password after your first login.

## Dashboards

This project includes the following dashboards:

-   **Ethereum Validator Cluster Overview:** A high-level overview of your entire validator cluster.
-   **Validator Cluster Performance:** Detailed performance metrics for your validators.
-   **Lido CSM Node (templated):** A templated dashboard for your Lido CSM nodes.
-   **EtherFi DVT Cluster:** A dashboard for your EtherFi DVT cluster.
-   **NodeSet Hyperdrive + StakeWise:** A dashboard for your NodeSet Hyperdrive and StakeWise validators.
-   **Rocketpool Validator Node:** A dashboard for your Rocketpool validator node.

These dashboards are automatically provisioned when you start the Grafana container.
