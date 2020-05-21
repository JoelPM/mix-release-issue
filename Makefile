DEV_IMAGE ?= devcontainer-elixir:1.10.3-1

devcontainer:
	docker build -t $(DEV_IMAGE) -f .devcontainer/Dockerfile .devcontainer/

shell:
	docker run \
	--rm \
	-w=/src \
	-v "$(CURDIR)":/src \
	-v ~/.ssh:/home/ex/.ssh:ro \
	-v ~/.config/gcloud:/home/ex/.config/gcloud:ro \
	-v /var/run/docker.sock:/home/ex/.docker.sock \
	-v /run/host-services/ssh-auth.sock:/home/ex/.ssh-auth.sock \
	--env SSH_AUTH_SOCK=/home/ex/.ssh-auth.sock \
	--env DOCKER_HOST="unix:///home/ex/.docker.sock" \
	-it \
	$(DEV_IMAGE)

release:
	SECRET_KEY_BASE=/NBr6SFx0KsgNTBymQOKbFFOP4uN8eO6mDMHKxkhmGSv+zKTNO3O4WShV5nFV9Am DATABASE_URL=null MIX_ENV=prod mix release
