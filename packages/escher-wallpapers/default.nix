{ pkgs, ... }:

let
  wallpaperUrls = [
    {
      name = "balcony.png";
      url = "https://i.imgur.com/RsIdrwK.png";
      hash = "sha256-wiSSMzw4UuwNUQjrOPKcx9lf0rQmm/9QLk8PVHfXRBY=";
    }
    {
      name = "rind.png";
      url = "https://i.imgur.com/b71r3S1.png";
      hash = "sha256-TzcSEr9nteUGGkHK2XOvw8BtA11Oka2yWyguqHxjLrA=";
    }
    {
      name = "butterflies.png";
      url = "https://i.imgur.com/F7gwZ0b.png";
      hash = "sha256-AnRo5MvAM4LH+jXDdMDAyu6Mr97KVnMUq3GfyVGjGek=";
    }
    {
      name = "double-planetoid.png";
      url = "https://i.imgur.com/mkoeHPU.png";
      hash = "sha256-h7RLiyUqshq0wInJ0w+rUG+POycJIpLYSyg+nSlJycs=";
    }
    {
      name = "liberation.png";
      url = "https://i.imgur.com/Rwu4dNj.png";
      hash = "sha256-gzyhUUEPKs5lRgGNpmqRTis1B66c/p3R3/H+ajR35to=";
    }
    {
      name = "relativity.png";
      url = "https://i.imgur.com/9UVgc1u.png";
      hash = "sha256-UzbFqHccEe8ue87jN7fXeg9s7WWdE80UO7H9vdhG0vY=";
    }
    {
      name = "devils.png";
      url = "https://i.imgur.com/Rv7erTM.png";
      hash = "sha256-gqiaqbxh1+lpW21ZNa1e+X8BQFmKfYFw3MTb+vB+Fyg=";
    }
    {
      name = "other-world.png";
      url = "https://i.imgur.com/qNb6sF9.png";
      hash = "sha256-d9rzUeTeKLOe1BBa+CI+M0Pjt1xmHVIX8JDxo9jSmlw=";
    }
    {
      name = "three-intersecting-planes.png";
      url = "https://i.imgur.com/9SLXNw3.png";
      hash = "sha256-LVLwK7B2k2X+7nZnRPPrSpO8w88U9dlwY+Bj7UeaqWc=";
    }
    {
      name = "three-spheres.png";
      url = "https://i.imgur.com/kVH5cWM.png";
      hash = "sha256-iKLpA7DY73us5hajKhXrpkwlKvBFKDw+VFs65hZPJqc=";
    }
    {
      name = "tree.png";
      url = "https://i.imgur.com/LkdNPgs.png";
      hash = "sha256-u7LiPrD5g7Ejt68wLZc9weaprlsVUE4cGBI2B7JtOAI=";
    }
    {
      name = "waterfall.png";
      url = "https://i.imgur.com/ENU8JbD.png";
      hash = "sha256-KtBOtPDV4XcWxVRO3WpNV5JyyZl97XdMYpxVe2JuOW4=";
    }
    {
      name = "ascending-and-descending.png";
      url = "https://i.imgur.com/sZbL0I9.png";
      hash = "sha256-9SDrfwSiFi4dHL9l3iOEFDX1bDXI+74f6Oh6hRZk4go=";
    }
    {
      name = "picture-gallery.png";
      url = "https://i.imgur.com/K8iefGQ.png";
      hash = "sha256-dWhLcTqH/aqciJtnEYQP1ddgyyiOPu8NBneJyWsYCOY=";
    }
    {
      name = "sky-and-water-2.png";
      url = "https://i.imgur.com/bMBgnGL.png";
      hash = "sha256-Niihyrvz12U+DJm0WTMcolWxXV6WSnOyMbNTaWJWkDU=";
    }
    {
      name = "sky-and-water-1.png";
      url = "https://i.imgur.com/vfyrRHC.png";
      hash = "sha256-O71siBRq8nzox4DNRB7oirdOYmy4V1nI2w2RM4CqQvQ=";
    }
    {
      name = "swans.png";
      url = "https://i.imgur.com/vHNhJu7.png";
      hash = "sha256-kCwufvaP9kmXCnOi2MjcqrBFOwzGI/pJDsCf/zrlDSM=";
    }
    {
      name = "stars.png";
      url = "https://i.imgur.com/FLSv6z5.png";
      hash = "sha256-v8srlbh7AW+Tm0/mD4XXT+DL3qUimkMEgROoWJgEsdE=";
    }
    {
      name = "three-worlds.png";
      url = "https://i.imgur.com/IOgXgCp.png";
      hash = "sha256-hTazRg44ydZS42qavq1fEog8jTRiz/60tGckSr61FgA=";
    }
  ];
in pkgs.linkFarm "escher-wallpapers" (map (x: { inherit (x) name; path = pkgs.fetchurl x; }) wallpaperUrls)
