FROM node:13.12.0-alpine as react-build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
ADD . .
RUN npm install --silent
RUN npm run test -- --watchAll=false
RUN npm run build

FROM nginx:stable-alpine
WORKDIR /app/code
COPY --from=react-build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]