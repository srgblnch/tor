# getops:
# short option:
# - single character: stand option
# - character followed by ':': requires an argument
# - character followed by '::': argument optional
# long options: (options separed by ',')
# - the same ':' and '::' meanings

#distributionss="debian raspbian"
releases="jessie stertch"


# TODO: fix distribution selection, and
#       change releases available depending on it

# TODO: setup a way to configure launch options,
#       like '--restart unless-stopped' against '--rm'.

while getopts "h-:" optchar; do
	case ${optchar} in
		-)
			case "${OPTARG}" in
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
			esac;;
		h)
			echo -e "\noptions:"
			#echo "--distribution=debian|raspbian"
			echo "--release=jessie|stretch"
			echo ""
			exit 1
			;;
		\?)
			echo "invalir option: -$OPTARG"
			exit 1
			;;
	esac
done

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

