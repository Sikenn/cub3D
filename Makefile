#############
# VARIABLES #
#############

NAME 	= cub3d
CC	= clang
CFLAGS	+= -Wall 
CFLAGS  += -Wextra 
CFLAGS  += -Werror
MLXLINK += -L -lmlx -lXext -lX11 -lbsd
MLXLINK += -lm

############
# INCLUDES #
############

# internal
PATH_INCLUDES = includes
INCLUDES += -I$(PATH_INCLUDES)

# libft
PATH_LIBFT = libft
INCLUDES += -I$(PATH_LIBFT)/includes
LIBFT = $(PATH_LIBFT)/libft.a

# minilibX
PATH_MLX = mlx_linux
INCLUDES += -I$(PATH_MLX)
MLX = $(PATH_MLX)/libmlx.a

###########
# Headers #
###########

vpath %.h $(PATH_INCLUDES)

#############
# SRCS PATH #
#############

PATH_SRCS = srcs

########
# SRCS #
########

# core
SRCS += main.c

##############
# ATRIBUTION #
##############

vpath %.c $(PATH_SRCS)

###########
# OBJECTS #
###########

PATH_OBJS = objs/
OBJS = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS))

#########
# RULES #
#########

all: $(PATH_OBJS) $(NAME)

$(NAME): $(OBJS) $(MLX)
	$(CC) $(MLXLINK) -o $@ $^ $(MLX)

$(OBJS): $(PATH_OBJS)%.o: %.c $(HEADER) Makefile
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(MLX):
	make -C $(PATH_MLX)

$(PATH_OBJS):
	mkdir $@

clean:
	make clean -C $(PATH_MLX)
	$(RM) $(OBJS)
	$(RM) -R $(PATH_OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
.PHONY: all clean fclean re


