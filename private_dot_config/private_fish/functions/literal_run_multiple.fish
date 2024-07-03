function run_multiple --description 'Run a command multiple times'
    argparse 'h/help' 'r/runs=!_validate_int --min 1' 'f/fails=!_validate_int --min 1' -- $argv
    or return

    set max_run 10
    set max_test_failed -1
    set print_help 0

    if test ( count $argv ) -eq 0;
        echo "Command to run must be provided."
        set print_help 1
    end
    if set -ql _flag_help
        set print_help 1
    end

    if test "$print_help" -eq 1;
        echo "run_multiple [-h|--help] [-r|runs #] [--forever] [-f|--fails #] -- [COMMAND ...]"
        echo ""
        echo "Arguments:"
        echo "  runs - Run this many times, default run 10 times"
        echo "  forever - Run forever"
        echo "  fails - Run until this many failures, default do not break on failure"
        return 0
    end

    if set -ql _flag_runs
        set max_run $_flag_runs
    end
    if set -ql _flag_forever
        set max_run -1
    end
    if set -ql _flag_fails
        set max_test_failed _flag_fails
    end

    echo "Running '$argv' for $max_run times until $max_test_failed failures"

    set test_run 0
    set test_passed 0
    set test_failed 0
    while true
        set test_run (math $test_run + 1)
        if $argv;
            echo "Test run $test_run passed"
            set test_passed (math $test_passed + 1)
        else
            echo "Test run $test_run failed!"
            set test_failed (math $test_failed + 1)
            if test \( "$max_test_failed" -gt 0 \) -a \( "$test_failed" -ge "$max_test_failed" \);
                echo "$test_failed tests failed, stopping"
                break
            end
        end
        if test \( "$max_run" -gt 0 \) -a \( "$test_run" -ge "$max_run" \);
            echo "$test_run tests run, stopping"
            break
        end
    end
    echo "Out of $test_run tests, $test_passed passed and $test_failed failed."
end
