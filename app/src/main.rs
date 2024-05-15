use anyhow::Result;
use axum::Router;
use clap::Parser;
use std::net::SocketAddr;
use tokio::net::TcpListener;

use simple_time_service::{config::AppConfig, routes};

/// Initializes axum app & logger, and serves.
#[tokio::main]
async fn main() -> Result<()> {
    let config = AppConfig::parse();
    let logger = config.get_logger();
    let addr = config.get_addr();
    logger.init()?;

    // Merge with route's router
    let app = Router::new().merge(routes::router());
    // Lets us access connection info from requests
    let service = app.into_make_service_with_connect_info::<SocketAddr>();

    log::info!("Listening on {addr}");
    axum::serve(TcpListener::bind(addr).await?, service)
        .with_graceful_shutdown(handle_shutdown())
        .await?;

    Ok(())
}

async fn handle_shutdown() {
    tokio::signal::ctrl_c().await.unwrap()
}
