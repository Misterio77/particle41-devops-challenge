use axum::{extract::ConnectInfo, routing, Json, Router};
use chrono::{DateTime, Utc};
use serde::Serialize;
use std::net::SocketAddr;

/// Response containing timestamp and ip
#[derive(Serialize)]
struct TimeAndIpResponse {
    timestamp: DateTime<Utc>,
    ip: SocketAddr,
}

/// Returns TimeAndIpResponse with the current timestamp and the client's IP, serialized as JSON
async fn get_time_and_ip(ConnectInfo(ip): ConnectInfo<SocketAddr>) -> Json<TimeAndIpResponse> {
    let timestamp = Utc::now();
    Json(TimeAndIpResponse { timestamp, ip })
}

/// Returns a router, to be merged with the main one
pub fn router() -> Router {
    Router::new().route("/", routing::get(get_time_and_ip))
}
