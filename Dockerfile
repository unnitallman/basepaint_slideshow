FROM ghcr.io/railwayapp/nixpacks:ubuntu-1711411379

ENTRYPOINT ["/bin/bash", "-l", "-c"]
WORKDIR /app/


COPY .nixpacks/nixpkgs-bf744fe90419885eefced41b3e5ae442d732712d.nix .nixpacks/nixpkgs-bf744fe90419885eefced41b3e5ae442d732712d.nix
RUN nix-env -if .nixpacks/nixpkgs-bf744fe90419885eefced41b3e5ae442d732712d.nix && nix-collect-garbage -d


ARG CI NIXPACKS_METADATA NODE_ENV NPM_CONFIG_PRODUCTION
ENV CI=$CI NIXPACKS_METADATA=$NIXPACKS_METADATA NODE_ENV=$NODE_ENV NPM_CONFIG_PRODUCTION=$NPM_CONFIG_PRODUCTION

# setup phase
# noop

# install phase
ENV NIXPACKS_PATH /app/node_modules/.bin:$NIXPACKS_PATH
COPY . /app/.
RUN --mount=type=cache,id=e7WaEUfAsKI-/root/npm,target=/root/.npm npm ci

# build phase
# noop


RUN printf '\nPATH=/app/node_modules/.bin:$PATH' >> /root/.profile


# start
COPY . /app
CMD ["npx serve ."]

