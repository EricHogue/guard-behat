
#require "guard/behat/version.rb"
require 'guard'
require 'guard/guard'

module Guard


	class Behat < Guard

		DEFAULT_OPTIONS = {
			:all_on_start   => true,
			:tests_path     => Dir.pwd
		}

		# Initialize a Guard.
		# @param [Array<Guard::Watcher>] watchers the Guard file watchers
		# @param [Hash] options the custom Guard options
		def initialize(watchers = [], options = {})
			defaults = DEFAULT_OPTIONS.clone
			@options = defaults.merge(options)

			super(watchers, @options)
		end

		# Call once when Guard starts. Please override initialize method to init stuff.
		# @raise [:task_has_failed] when start has failed
		def start
			run_all if options[:all_on_start]
		end

		# Called when `reload|r|z + enter` is pressed.
		# This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
		# @raise [:task_has_failed] when reload has failed
		def reload
			run_all if options[:all_on_start]
		end

		# Called when just `enter` is pressed
		# This method should be principally used for long action like running all specs/tests/...
		# @raise [:task_has_failed] when run_all has failed
		def run_all
			puts 'Run all Behat tests'
			puts `behat`
			success = last_command_is_successful?

			notify success
			throw :task_has_failed unless success
		end

		# Called on file(s) modifications that the Guard watches.
		# @param [Array<String>] paths the changes files or paths
		# @raise [:task_has_failed] when run_on_change has failed
		def run_on_changes(paths)
			paths.each do |file|
				puts "Behat #{file}"
				puts `behat #{file}`
				success = last_command_is_successful?

				throw :task_has_failed unless success
			end
			notify success
		end

		def last_command_is_successful?
			0 == $?.exitstatus
		end

		def notify(success)
			return if options[:notification] == false

			if success
				message = "Behat tests succeeded"
				image = :success
			else
				message = "Behat tests failed"
				image = :failed
			end

			 ::Guard::Notifier.notify(message, {:title => 'Behat results', 
				:image => image})
		end

	end
end
