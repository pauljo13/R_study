___
## **RNA-Seq 데이터 분석 과정 설명**

이 코드는 **유전자 발현량 정규화(RPKM & TPM) → 그룹 비교(t-test) → 볼케이노 플롯(Volcano plot) 생성** 과정을 수행합니다.  
전체 흐름을 하나씩 분석해볼게요.

---

### **1. RPKM과 TPM 계산**

```r
rpkm.data <- apply(expr, 2, function(x) cal_rpkm(x, gene.len))
tpm.data <- apply(expr, 2, function(x) cal_tpm(x, gene.len))
```

✅ **설명**

- `expr`: 원본 유전자 발현 행렬 (행 = 유전자, 열 = 샘플)
- `gene.len`: 유전자의 길이 (bp, base pairs)
- `cal_rpkm()` 및 `cal_tpm()`: 각각 RPKM과 TPM을 계산하는 사용자 정의 함수
- `apply(expr, 2, function(x) ...)`는 **열(column) 단위로 함수를 적용**하여, 모든 샘플(컬럼)에 대해 RPKM 및 TPM을 계산함

---

### **2. 로그 변환 (Log2 Transformation)**

```r
rpkm.data.lg2 <- log2(rpkm.data + 1)
tpm.data.lg2 <- log2(tpm.data + 1)
```

✅ **설명**

- 로그 변환을 하면 데이터 분포가 정규 분포에 가깝게 변하여 **통계 분석이 용이**함
- `log2(x + 1)`: `+1`을 추가하여 0이 존재할 때 **log(0) → -Inf 문제를 방지**
- `rpkm.data.lg2`와 `tpm.data.lg2`는 로그 변환된 RPKM과 TPM 데이터

---

### **3. 샘플 그룹 지정 (Kidney vs. Liver)**

```r
group <- rep('kidney', ncol(tpm.data.lg2))  
group[grep("Liver", colnames(tpm.data.lg2))] = "liver"
```

✅ **설명**

- 기본적으로 모든 샘플을 `"kidney"` 그룹으로 지정
- `grep("Liver", colnames(tpm.data.lg2))`는 **샘플 이름에 "Liver"가 포함된 열의 인덱스를 찾음**
- 해당 샘플들을 `"liver"` 그룹으로 변경
- 즉, **샘플을 "kidney" vs "liver" 두 그룹으로 나누는 과정**

---

### **4. 유전자별 t-검정 수행**

```r
tres = apply(tpm.data.lg2, 1, function(x) t.test(x~group))
```

✅ **설명**

- `apply(tpm.data.lg2, 1, function(x) t.test(x~group))`
    - `1` → 행 단위 적용 (각 유전자별로 수행)
    - `t.test(x ~ group)` → `group`에 따라 두 집단 비교
- 즉, **각 유전자별로 kidney와 liver 그룹 간 t-test 수행하여 유의미한 차이가 있는지 검정**

---

### **5. t-test 결과에서 p-value 및 Fold Change(FC) 추출**

```r
tp <- sapply(tres, function(x) x$p.value)
td <- sapply(tres, function(x) x$estimate[2] - x$estimate[1])
```

✅ **설명**

- `tp`: 각 유전자의 **p-value** (kidney vs liver 비교)
- `td`: Fold Change (로그 변환된 발현값 차이)
    - `x$estimate[2] - x$estimate[1]` → **liver - kidney 값 차이**
    - 값이 **양수(+)면 liver에서 높고, 음수(-)면 kidney에서 높음**

```r
names(td) <- names(tres)
```

✅ **오류 가능성**

- `trees`는 존재하지 않는 객체이므로, 이 줄에서 **오류 발생 가능성 높음**
- 올바른 코드는 `names(td) <- names(tres)`

---

### **6. 볼케이노 플롯(Volcano Plot) 생성**

```r
logtp <- -log10(tp)
plot(x=td, y=logtp, xlab="fold change", ylab="-logP", main = "Volcano plot of kidney vs. liver")
```

✅ **설명**

- `logtp = -log10(tp)`: p-value를 로그 변환하여 y축으로 사용 (p-value가 작을수록 높은 값)
- `plot(x=td, y=logtp, xlab="fold change", ylab="-logP")`
    - x축: **Fold Change (FC)**
    - y축: **-log10(p-value)** (p-value가 작을수록 더 위에 위치)
    - 유전자별로 두 그룹(kidney vs liver)의 차이를 시각화함

---

## **📌 최종 정리**

1️⃣ **RPKM 및 TPM을 계산**  
2️⃣ **로그 변환(Log2 transformation)으로 데이터 정규화**  
3️⃣ **Kidney vs. Liver 샘플 분류**  
4️⃣ **t-test를 수행하여 유전자별 p-value 및 Fold Change(FC) 계산**  
5️⃣ **볼케이노 플롯(Volcano Plot)으로 시각화하여 의미 있는 유전자 식별**

🚀 **볼케이노 플롯 해석**

- **오른쪽 (FC > 0, p-value 작음)** → Liver에서 발현 증가 (Upregulated in Liver)
- **왼쪽 (FC < 0, p-value 작음)** → Kidney에서 발현 증가 (Upregulated in Kidney)
- **중앙 (FC ≈ 0)** → 발현 차이가 크지 않음

---
