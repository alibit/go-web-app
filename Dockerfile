# Build stage - Golang
# Use a multi-stage build to keep the final image small
# First stage - Build the Go application
FROM golang:1.21 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .

# Final stage - Disroless image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD [ "./main" ]
