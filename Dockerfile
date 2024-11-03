# Etapa de build
FROM golang:1.22 AS builder

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo go.mod e o código para dentro do contêiner
COPY go.mod .
COPY main.go .

# Compila o código Go para um executável estático
RUN CGO_ENABLED=0 GOOS=linux go build -o fullcycle

# Etapa final: cria a imagem final
FROM scratch

# Copia o executável da etapa de build para a imagem final
COPY --from=builder /app/fullcycle /fullcycle

# Define o comando de execução
CMD ["/fullcycle"]
