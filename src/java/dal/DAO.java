/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import models.Categories;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import models.Products;
import java.sql.Date;
import models.ProductStatistics;

/**
 *
 * @author LE VAN THUAN
 */
public class DAO extends DBContext {

    //CATEGORIES
    public List<Categories> getAll() {
        List<Categories> listCate = new ArrayList<>();
        String sql = "select * from Categories where IsDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = new Categories(rs.getInt("cateID"), rs.getString("cateName"), rs.getDate("create_At"));
                listCate.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listCate;
    }

    public Categories getCategoryById(int id) {
        String sql = "select * from Categories where CateID=? and isDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Categories c = new Categories(rs.getInt("CateID"), rs.getString("CateName"), rs.getDate("create_At"));
                return c;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public Categories getCategoryByName(String name) {
        String sql = "select * from Categories where CateName=? and isDeleted = 0 ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Categories c = new Categories(rs.getInt("CateID"), rs.getString("CateName"), rs.getDate("create_At"));
                return c;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public void addCate(Categories c) {
        String sql = "insert into Categories (cateName) values (?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getCateName());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void deleteCateById(int cid) {
        String sql = "update Categories set IsDeleted = 1 where CateID = ?";
        String sql1 = "update Products set IsDeleted = 1 where CateID = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);
            ps.executeUpdate();

            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ps1.setInt(1, cid);
            ps1.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void updateCate(Categories c) {
        String sql = "update categories set catename = ? where cateid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getCateName());
            ps.setInt(2, c.getCateID());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    //PRODUCTS
    public List<Products> getAllProducts() {
        List<Products> listProd = new ArrayList<>();
        String sql = "select * from products where isDeleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public void addProd(Products p) {
        String sql = "insert into Products (ProdID, ProdName, Image, Quantity, Price, Describe, CateID) values (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, p.getProdID());
            ps.setString(2, p.getProdName());
            ps.setString(3, p.getImage());
            ps.setInt(4, p.getQuantity());
            ps.setDouble(5, p.getPrice());
            ps.setString(6, p.getDescribe());
            ps.setInt(7, p.getCategory().getCateID());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void deleteProdById(String pid) {
        String sql = "update Products set IsDeleted = 1 where ProdID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, pid);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void updateProd(Products p) {
        String sql = "update products set prodname = ?, image = ?, quantity = ?, price = ?, describe = ? where prodid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, p.getProdName());
            ps.setString(2, p.getImage());
            ps.setInt(3, p.getQuantity());
            ps.setDouble(4, p.getPrice());
            ps.setString(5, p.getDescribe());
            ps.setString(6, p.getProdID());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public List<Products> getNewProduct() {
        List<Products> listProd = new ArrayList<>();
        String sql = "select top 10 * from products where isDeleted = 0 order by create_At desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public List<Products> getOldProduct() {
        List<Products> listProd = new ArrayList<>();
        String sql = "select top 5 * from products order by create_At";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public List<Products> getProductByKey(String key) {
        String sql = "select * from products where isDeleted = 0 and prodname like ?";
        List<Products> listProd = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + key + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public Products getProductsByPid(String pid) {
        String sql = "select * from products where isDeleted = 0 and prodID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, pid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                return p;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }

    public List<Products> getProductsById(int cid) {
        List<Products> listProd = new ArrayList<>();
        String sql = "select * from products where 1 = 1 and isDeleted = 0 ";
        if (cid != 0) {
            sql += " and cateID = " + cid;
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public List<Products> getProductsByCateID(int cateID, String excludeProdID) {
        List<Products> listProd = new ArrayList<>();
        String sql = "select * from products where isDeleted = 0 and cateID = ? and prodID <> ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cateID);
            ps.setString(2, excludeProdID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));

                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);

                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }

        return listProd;
    }

    public List<Products> searchByFilters(String[] cateIDs, String[] priceRanges, String sortByPrice) {
        List<Products> listProd = new ArrayList<>();
        String sql = "select * from products where 1=1 and isDeleted = 0 ";

        if (cateIDs != null && cateIDs.length > 0) {
            sql += " and cateID in (" + String.join(",", cateIDs) + ")";
//            for (int i = 0; i < cateIDs.length; i++) {
//                sql += cateIDs[i];
//                if (i < cateIDs.length - 1) {
//                    sql += ", ";
//                }
//            }
//            sql += ")";
        }

        if (priceRanges != null && priceRanges.length > 0) {
            sql += " and (";
            for (int i = 0; i < priceRanges.length; i++) {
                String[] range = priceRanges[i].split("-");
                sql += "(price between " + range[0] + " and " + range[1] + ")";
                if (i < priceRanges.length - 1) {
                    sql += " or ";
                }
            }
            sql += ")";
        }

        if (sortByPrice != null && !sortByPrice.isEmpty()) {
            if ("asc".equals(sortByPrice)) {
                sql += " ORDER BY price ASC";
            } else if ("desc".equals(sortByPrice)) {
                sql += " ORDER BY price DESC";
            }
        }

        System.out.println("Generated SQL: " + sql);

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));

                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);

                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public List<Products> getProductsByPage(int cateID, int page, int pageSize) {
        List<Products> listProd = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "select * from Products "
                + "where (? = 0 or CateID = ?) and isDeleted = 0 "
                + "order by ProdID "
                + "offset ? rows fetch next ? rows only";
        //offset ? row: bo qua ? san pham dau tien
        //fetch next: lay san pham tiep theo, theo pageSize
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cateID);
            ps.setInt(2, cateID);
            ps.setInt(3, offset);
            ps.setInt(4, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("prodID"));
                p.setProdName(rs.getString("prodName"));
                p.setImage(rs.getString("image"));
                p.setQuantity(rs.getInt("quantity"));
                p.setPrice(rs.getDouble("price"));
                p.setDescribe(rs.getString("describe"));
                p.setCreate_At(rs.getDate("create_At"));
                Categories c = getCategoryById(rs.getInt("cateID"));
                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

    public int getTotalProducts(int cateID) {
        int total = 0;
        String sql = "select count(*) from Products where (? = 0 or CateID = ?) and isDeleted = 0 ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cateID);
            ps.setInt(2, cateID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return total;
    }

    public List<Products> getBestSellingProduct() {
        List<Products> listProd = new ArrayList<>();

        String sql = "select top 5 p.prodid, p.prodname, p.image, p.price, sum(od.quantity) as totalsold "
                + "from orderdetail od "
                + "join products p on od.prodid = p.prodid "
                + "where p.isDeleted = 0 "
                + "group by p.prodid, p.prodname, p.image, p.price, p.quantity "
                + "order by totalsold desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProdID(rs.getString("ProdID"));
                p.setProdName(rs.getString("ProdName"));
                p.setImage(rs.getString("Image"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("TotalSold"));
//                Categories c = getCategoryById(rs.getInt("cateID"));
//                p.setCategory(c);
                listProd.add(p);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProd;
    }

//    public static void main(String[] args) {
//        DAO dao = new DAO(); 
//        List<Categories> listCate = dao.getAll(); 
//
//        System.out.println("Categories List Size: " + listCate.size());
//        for (Categories c : listCate) {
//            System.out.println("Category ID: " + c.getCateID() + ", Name: " + c.getCateName());
//        }
//    }
    public static void main(String[] args) {
        DAO c = new DAO();
        List<Categories> list = c.getAll();
        System.out.println(list.get(2).getCateID());
    }

    public List<ProductStatistics> getProductStatistics() {
        List<ProductStatistics> stats = new ArrayList<>();
        String sql = "select p.prodid, p.prodname, p.quantity, sum(od.quantity) as totalsold from orderdetail od join products p on od.prodid = p.prodid join orders o on od.orderid = o.orderid where o.status != 'canceled' group by p.prodid, p.prodname, p.quantity;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductStatistics pst = new ProductStatistics();
                pst.setProdID(rs.getString("prodid"));
                pst.setProdName(rs.getString("prodname"));
                pst.setQuantity(rs.getInt("quantity"));
                pst.setTotalSold(rs.getInt("totalsold"));
                stats.add(pst);
            }

        } catch (SQLException e) {
            System.err.println(e);
        }

        return stats;
    }

    public int getProductQuantity(String prodID) {
        int quantity = 0;
        String sql = "SELECT Quantity FROM Products WHERE ProdID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, prodID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("Quantity");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

}
