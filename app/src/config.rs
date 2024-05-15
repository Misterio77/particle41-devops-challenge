use clap::Parser;
use log::LevelFilter;
use simple_logger::SimpleLogger;
use std::net::{IpAddr, SocketAddr};

/// Configuration for the application
/// Uses 'clap' to extract both from CLI as well as env vars
#[derive(Parser, Clone)]
pub struct AppConfig {
    #[clap(long, default_value = "::", env = "STS_HOST")]
    pub address: IpAddr,
    #[clap(long, default_value = "8080", env = "STS_PORT")]
    pub port: u16,
    #[clap(long, default_value = "info", env = "STS_LOG_LEVEL")]
    pub log_level: LevelFilter,
}

impl AppConfig {
    /// Get a SimpleLogger instance with configured log_level
    pub fn get_logger(&self) -> SimpleLogger {
        SimpleLogger::new().with_level(self.log_level)
    }
    /// Get configuration's parsed host + port
    pub fn get_addr(&self) -> SocketAddr {
        SocketAddr::from((self.address, self.port))
    }
}
