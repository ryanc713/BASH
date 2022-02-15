while [[ $# -gt 0 ]]
	do
 		case "$1" in
 			-a|--arg1)
 				arg1="$2"
 				shift
 				;;
 			--help|*)
				usage
 				;;
      --v|--version)
        echo "apachessl.sh V1.0"
        ;;
 		esac
 	shift
done
