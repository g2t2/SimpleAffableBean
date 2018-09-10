<%--

    BSD 3-Clause License

    Copyright (C) 2018 Steven Atkinson <steven@nowucca.com>
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this
      list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.

    * Neither the name of the copyright holder nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--%>
<jsp:useBean id="p" scope="request" type="viewmodel.admin.AdminOrdersViewModel"/>

<%-- orderList is requested --%>
<table id="adminTable" class="detailsTable detailsOrdersTable">

    <tr class="header">
        <th colspan="4">orders</th>
    </tr>

    <tr class="tableHeading">
        <td>order id</td>
        <td>confirmation number</td>
        <td>amount</td>
        <td>date created</td>
    </tr>

    <c:forEach var="order" items="${p.orderList}" varStatus="iter">

        <tr class="${((iter.index % 2) == 1) ? 'lightBlue' : 'white'} tableRow"
            onclick="document.location.href='<c:url value="/admin/order/${order.customerOrderId}"/>'">

                <%-- Below anchor tags are provided in case JavaScript is disabled --%>
            <td><a href="<c:url value="/admin/order/${order.customerOrderId}"/>" class="noDecoration">${order.customerOrderId}</a></td>
            <td><a href="<c:url value="/admin/order/${order.customerOrderId}"/>" class="noDecoration">${order.confirmationNumber}</a></td>
            <td><a href="<c:url value="/admin/order/${order.customerOrderId}"/>" class="noDecoration">
                <fmt:formatNumber type="currency"
                                  currencySymbol="&euro; "
                                  value="${order.amount/100.0}"/></a></td>

            <td><a href="<c:url value="/admin/order/${order.customerOrderId}"/>" class="noDecoration">
                <fmt:formatDate value="${order.dateCreated}"
                                type="both"
                                dateStyle="short"
                                timeStyle="short"/></a></td>
        </tr>

    </c:forEach>

</table>
