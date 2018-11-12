# getops:
# short option:
# - single character: stand option
# - character followed by ':': requires an argument
# - character followed by '::': argument optional
# long options: (options separed by ',')
# - the same ':' and '::' meanings

version="1.0.1-alpha"

#distributionss="debian raspbian"
releases="jessie stertch"


# TODO: fix distribution selection, and
#       change releases available depending on it

# TODO: setup a way to configure launch options,
#       like '--restart unless-stopped' against '--rm'.

function help {
	echo -e "\noptions:"
	echo "--image=torproxy"
	#echo "--distribution=debian|raspbian"
	echo "--release=jessie|stretch"
	echo ""
	exit 1
}

while getopts ":h-:" optchar; do
	case ${optchar} in
		-)
			case "${OPTARG}" in
			help)
				help
				;;
			image=*)
				export IMAGE=${OPTARG#*=}
				;;
			#distribution=*)
			#	echo "--distribution triggered, Parameter $OPTARG"
			#	if [ "$OPTARG" == "$distributions" ]; then
			#		echo "invalid 'distribution', not one of $distributions"
			#		exit 1
			#	fi
			#	export DISTRIBUTION=${OPTARG#*=}
			#	;;
			release=*)
				echo "--release triggered, Parameter $OPTARG"
				if [ "$OPTARG" == "$releases" ]; then
					echo "invalid 'RELEASE', not one of $releases"
					exit 1
				fi
				export RELEASE=${OPTARG#*=}
				;;
			*)
				echo "Invalid option: --$OPTARG"
				help
				exit 1
				;;
			esac;;
		h)
			help
			;;
		*)
			echo "Invalid option: -$OPTARG"
			help
			exit 1
			;;
	esac
done

if [ -v $IMAGE ]; then
	export IMAGE=torproxy
	# TODO: when it has more projects, no default and report the options
fi

if [ -v $DISTRIBUTION ]; then
	export DISTRIBUTION=debian
fi

if [ -v $RELEASE ]; then
	if [ "$DISTRIBUTION" == "debian" ]; then
		export RELEASE=stretch
	else
		export RELEASE=jessie
	fi
fi

