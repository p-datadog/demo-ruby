# Puma configuration file.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "development" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
plugin :tmp_restart

on_worker_boot do
  if ENV['SYMDB_EXTRACT_LOOP'] == 'true'
    require ::Rails.root.join('lib/stress/extraction_loop').to_s
    ::Stress::ExtractionLoop.start!
  end

  # Re-open appenders after forking the process
  begin
    ::SemanticLogger.reopen
  rescue NameError
    # SemanticLogger constant not visible in Puma::DSL on_worker_boot context;
    # appenders will continue using their pre-fork file handles.
  end
end
